FROM node:latest

ENV NODE_ENV=development

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# COPY package*.json ./
# RUN npm install

COPY . .

COPY ssh_plugin/ /opt/ssh_plugin/
RUN chmod +x /opt/ssh_plugin/install_ssh.sh /opt/ssh_plugin/entrypoint.sh \
    && /opt/ssh_plugin/install_ssh.sh

EXPOSE 5173 22

ENTRYPOINT ["/opt/ssh_plugin/entrypoint.sh"]
CMD ["npm", "start"]
