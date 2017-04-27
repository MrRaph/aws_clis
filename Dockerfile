FROM python:slim

VOLUME "/root/.aws"
ADD ./help.sh /root/help.sh
CMD "/root/help.sh"

RUN pip install --upgrade --user awsebcli && \
    pip install --upgrade --user awscli && \
    apt update && apt install --no-install-recommends -y groff curl && \
    curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest && \
    echo "export PATH=\"\$PATH:/root/.local/bin/:/usr/local/bin/\"" >> /etc/profile.d/expand_path.sh && \
    chmod +x /usr/local/bin/ecs-cli /root/help.sh /etc/profile.d/expand_path.sh && \
    mkdir -p /root/.aws /root/.elasticbeanstalk/config && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/root/.local/bin/:/usr/local/bin/"
