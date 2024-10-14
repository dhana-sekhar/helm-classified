# helm-classified

I hope you already had basic understanding of Kubernetes YAML files.

Since you're already familiar with Kubernetes YAML files, understanding Helm will be much easier for you. Helm is a powerful tool for managing Kubernetes applications by using charts, which are like templates for Kubernetes resources.

### Here's a basic plan to get you started with Helm:

#### 1. **What is Helm?**
Helm is a package manager for Kubernetes, allowing you to define, install, and upgrade complex Kubernetes applications. It organizes Kubernetes YAML manifests into reusable "charts," which makes deployments more efficient and scalable.

#### 2. **Helm Components**
- **Chart**: A Helm package that contains all the Kubernetes manifest files.
- **Release**: A running instance of a Helm chart in a Kubernetes cluster.
- **Repository**: Where Helm charts are stored and shared.

#### 3. **Creating a Helm Chart**
You can create your first Helm chart to start learning. Here’s a step-by-step guide to creating a simple chart.

##### Step 1: Create a Helm Chart
Run the following command to create a new chart:
```bash
helm create my-first-chart
```

This will generate a directory structure that includes:
- `Chart.yaml`: Metadata about the chart (name, version, etc.).
- `values.yaml`: Default values that are passed to the templates.
- `templates/`: Contains your Kubernetes YAML templates.

##### Step 2: Understand the Files
- **Chart.yaml**: 
   It defines metadata for your chart.
   ```yaml
   apiVersion: v2
   name: my-first-chart
   version: 0.1.0
   ```
- **values.yaml**: 
   It stores default configuration values, which will be used in your templates.
   ```yaml
   replicaCount: 1
   image:
     repository: nginx
     tag: latest
   ```

- **templates/**: Contains your Kubernetes manifests. Helm will inject values from `values.yaml` or from command-line overrides into these templates.

##### Step 3: Customize Your Chart
Let’s modify the default deployment in `templates/deployment.yaml`. In the YAML, you’ll find placeholders like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-deployment
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
```

These placeholders (`{{ }}`) are using the Go templating language. Helm injects values from `values.yaml` or command-line arguments when deploying.

#### 4. **Installing the Chart**
To install the Helm chart into your Kubernetes cluster:

```bash
helm install my-release ./my-first-chart
```

Here:
- `my-release` is the name of the Helm release.
- `./my-first-chart` points to the chart directory you just created.

Helm will generate Kubernetes resources based on the templates and deploy them to your cluster.

#### 5. **Working with Values**
You can override `values.yaml` defaults by passing values via the command line:

```bash
helm install my-release ./my-first-chart --set replicaCount=3
```

This overrides the replica count from 1 to 3, making the deployment scale with 3 replicas.

#### 6. **Upgrading a Release**
If you make changes to your chart or its values, you can upgrade the running release:
```bash
helm upgrade my-release ./my-first-chart --set image.tag=v2
```
This upgrades the application to use the new image version (`v2`).

#### 7. **Uninstalling a Release**
To uninstall a release and clean up all resources created by Helm:
```bash
helm uninstall my-release
```

#### 8. **Helm Repositories**
You can add public repositories to install pre-packaged charts, for example:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami
```

This will give you access to a wide range of pre-built charts you can install or use as references.

### Next Steps
- Play around with the Helm chart values and templates.
- Explore how Helm can manage multiple environments (e.g., dev, staging, prod) using different values files.
- Dive into Helm hooks, testing, and chart dependencies.

Let me know what you’d like to dive deeper into, and I can guide you through any part of Helm!