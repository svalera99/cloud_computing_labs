To reproduse:

### grype
```bash
grype ghcr.io/mlflow/mlflow:v2.3.0 --only-fixed |  grep -i -E '(High|Critical)'
```

### trivy
```bash
trivy  image --severity HIGH,CRITICAL --ignore-unfixed ghcr.io/mlflow/mlflow:v2.3.0
```