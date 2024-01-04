# Build the manager binary
FROM quay.io/operator-framework/helm-operator:v1.33.0

ENV HOME=/opt/helm
COPY crd/watches.yaml ${HOME}/watches.yaml
COPY helm  ${HOME}/helm-charts
WORKDIR ${HOME}

