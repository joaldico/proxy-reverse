# proxy-reverse

Nginx Docker (`network_mode: host`) que sustituye `/etc/nginx` en la EC2.

| Host | Destino |
| --- | --- |
| enterprisesolutionstech.com | `localhost:3000` |
| jessirecrea.com | `localhost:3001` (`jessica-web`) |
| josuediazcontreras.com | `localhost:3002` (`josue-diaz-web`) |

`jessicapabonsantiago.com`, formacionacademica y `/notifications` están comentados en `nginx/default.conf`.

## Corte

```bash
sudo systemctl stop nginx
sudo systemctl disable nginx
docker compose up -d
```

SSH a la máquina (IP de hoy):

```bash
ssh -i "josue-servidor-ec2.pem" ubuntu@34.229.153.21
```

## Runner global

En la EC2, con un token de GitHub (org o repo):

```bash
export RUNNER_URL="https://github.com/joaldico"
export RUNNER_TOKEN="..."
./scripts/install-runner.sh
```

Los workflows usan `runs-on: [self-hosted, Linux, X64]`. No hay IP en los YAML.
