FROM mcr.microsoft.com/azure-cli:2.1.0

ENV KUBECTL_VERSION="v1.17.3"
ENV KUSTOMIZE_VERSION="v3.5.4"
ENV ISTIO_VERSION="1.4.5"
ENV ARGOCD_VERSION="v1.4.2"
ENV SEALED_SECRET_VERSION="v0.9.7"
ENV YQ_VERSION="3.1.1"
ENV HELM_VERSION="v3.1.0"

WORKDIR /tmp

RUN apk --no-cache add ncurses=6.1_p20190518-r2 coreutils=8.31-r0 \
 && curl -L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -o yq \
 && install -m 755 -o root -g bin yq /usr/local/bin/yq \
# Setup kubectl
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o kubectl \
 && install -m 755 -o root -g bin kubectl /usr/local/bin/kubectl \
# Setup kubeseal (i.e sealed-secrets)
 && curl -L https://github.com/bitnami-labs/sealed-secrets/releases/download/${SEALED_SECRET_VERSION}/kubeseal-linux-amd64 -o kubeseal \
 && install -m 755 -o root -g bin kubeseal /usr/local/bin/kubeseal \
# Setup helm
 && curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm-linux-amd64.tar.gz \
 && tar -zxf helm-linux-amd64.tar.gz \
 && install -m 755 -o root -g bin linux-amd64/helm /usr/local/bin/helm \
# Setup can we use a version for this !?
 && git clone https://github.com/ahmetb/kubectx kubectx \
 && install -m 755 -o root -g bin kubectx/kubectx /usr/local/bin/kubectx \
 && install -m 755 -o root -g bin kubectx/kubens /usr/local/bin/kubens \
# Setup can we use a version for this !?
 && git clone https://github.com/WirelessCar-Cyclone/configuration-management-script ccm \
 && install -m 755 -o root -g bin ccm/src/bash/git-setup /usr/local/bin/git-setup \
 && install -m 755 -o root -g bin ccm/src/bash/git-publish /usr/local/bin/git-publish \
 && install -m 755 -o root -g bin ccm/src/bash/git-tag /usr/local/bin/git-tag \
 && install -m 755 -o root -g bin ccm/src/bash/docker-import /usr/local/bin/docker-import \
 && install -m 755 -o root -g bin ccm/src/make/application /usr/local/bin/application \
 && rm -rf /tmp/*

COPY "entrypoint.sh" "/entrypoint.sh"

WORKDIR /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kustomize"]
