#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

required_files=(
  "README.md"
  "LICENSE"
  "CONTRIBUTING.md"
  "Xamarin.Essentials.sln"
  "Xamarin.Essentials/Xamarin.Essentials.csproj"
  "Tests/Tests.csproj"
  "azure-pipelines.yml"
  ".github/workflows/validate.yml"
  "docs/index.md"
  "repo-state.md"
)

for path in "${required_files[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

python3 - <<'PY'
from pathlib import Path
import sys
import xml.etree.ElementTree as ET

required_dirs = [
    Path("Xamarin.Essentials"),
    Path("Tests"),
    Path("DeviceTests"),
    Path("Samples"),
    Path("docs/en"),
]

missing = [str(path) for path in required_dirs if not path.is_dir()]
if missing:
    print("Missing required directories: " + ", ".join(missing), file=sys.stderr)
    sys.exit(1)

source_files = list(Path("Xamarin.Essentials").rglob("*.cs"))
test_files = list(Path("Tests").glob("*_Tests.cs"))
if len(source_files) < 100:
    print(f"Expected substantial library source, found {len(source_files)} C# files", file=sys.stderr)
    sys.exit(1)
if len(test_files) < 20:
    print(f"Expected substantial unit coverage, found {len(test_files)} test files", file=sys.stderr)
    sys.exit(1)

xml_files = [
    Path("Xamarin.Essentials/Xamarin.Essentials.csproj"),
    Path("Tests/Tests.csproj"),
    Path("Directory.Build.props"),
    Path("docs/frameworks.xml"),
    Path("docs/en/docfx.json"),
]

for path in xml_files:
    if path.suffix == ".json":
        continue
    try:
        ET.parse(path)
    except ET.ParseError as exc:
        print(f"Invalid XML in {path}: {exc}", file=sys.stderr)
        sys.exit(1)

project = Path("Xamarin.Essentials/Xamarin.Essentials.csproj").read_text(encoding="utf-8-sig")
expected_targets = [
    "netstandard1.0",
    "netstandard2.0",
    "Xamarin.iOS10",
    "MonoAndroid10.0",
    "tizen40",
]
missing_targets = [target for target in expected_targets if target not in project]
if missing_targets:
    print("Missing expected target frameworks: " + ", ".join(missing_targets), file=sys.stderr)
    sys.exit(1)

readme = Path("README.md").read_text(encoding="utf-8")
for phrase in ["Xamarin.Essentials", "Supported Platforms", "Building Xamarin.Essentials"]:
    if phrase not in readme:
        print(f"README is missing expected section text: {phrase}", file=sys.stderr)
        sys.exit(1)
PY

python3 -m json.tool docs/en/docfx.json >/dev/null

if [[ "${ESSENTIALS_SKIP_DOTNET_RESTORE:-0}" != "1" ]]; then
  dotnet restore Tests/Tests.csproj --no-cache --verbosity minimal
else
  echo "Skipping dotnet restore because ESSENTIALS_SKIP_DOTNET_RESTORE=1"
fi

echo "Essentials validation passed."
