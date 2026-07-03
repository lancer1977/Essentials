# DevStudio Notes

`Essentials` is maintained as a legacy Xamarin.Essentials source snapshot. The local
health gate uses `scripts/validate.sh` as the portable check for repository shape,
metadata, XML validity, and test-project restore.

The full release pipeline remains `azure-pipelines.yml`, which depends on Microsoft
and Xamarin build infrastructure plus platform workloads that are outside a normal
Linux developer environment.
