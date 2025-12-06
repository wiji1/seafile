# Seafile-Helm-Chart

This repository contains a highly specialized Helm chart for running Seafile with an ArgoCD setup.

> [!WARNING]
> This is a very hacky solution and I would not recommend using this in production environments. This chart remains untested with any non out-of-the-box Seafile features.

## Deployment

### Preparation

- Create namespace

    ```
    kubectl create namespace seafile
    ```

- Create secret

    ```sh
    kubectl create secret generic seafile-secret --namespace seafile \
        --from-literal=JWT_PRIVATE_KEY='<required>' \
        --from-literal=SEAFILE_MYSQL_DB_PASSWORD='<required>' \
        --from-literal=INIT_SEAFILE_ADMIN_PASSWORD='<required>' \
        --from-literal=INIT_SEAFILE_MYSQL_ROOT_PASSWORD='<required>' \
        --from-literal=REDIS_PASSWORD='' 
    ```

    where `JWT_PRIVATE_KEY` can get from `pwgen -s 40 1`

<br>

### Install Seafile helm chart Via ArgoCD

1. In the ArgoCD UI, click **"+ NEW APP"**
2. Configure the application:
   - **Application Name**: `seafile`
   - **Project**: `default`
   - **Sync Policy**: `Manual`

   **Source:**
   - **Repository URL**: `https://github.com/wiji1/seafile.git`
   - **Revision** : `main` (branch)
   - **Path**: `helm`

   **Destination:**
   - **Cluster URL**: `https://kubernetes.default.svc` (internal cluster URL)
   - **Namespace**: `seafile`

3. Click **CREATE**

### Sync the Infrastructure Configuration

1. In ArgoCD, open the application
2. Click **SYNC**
3. Let ArgoCD deploy the infrastructure components

## Logging In
The default credentials for the admin user are:
```
me@example.com : asecret
```

After logging in, you can create a new user and give it administrator access.

> [!WARNING]
> PLEASE remember to delete or change the password of the default user after the initial login.