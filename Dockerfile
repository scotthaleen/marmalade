FROM mongo:4.0.24-xenial

RUN apt-get update && apt-get clean && apt-get install -y \
    curl

RUN mkdir /app
WORKDIR /app

ENV NVM_DIR /app/.nvm
ENV NODE_VERSION v0.10.48

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash && \
    chmod +x $NVM_DIR/nvm.sh && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default "$NODE_VERSION" && \
    nvm use default && \
    DEFAULT_NODE_VERSION=$(nvm version default) && \
    ln -sf /app/.nvm/$DEFAULT_NODE_VERSION/bin/node /usr/bin/nodejs && \
    ln -sf /app/.nvm/$DEFAULT_NODE_VERSION/bin/node /usr/bin/node && \
    ln -sf /app/.nvm/$DEFAULT_NODE_VERSION/bin/npm /usr/bin/npm

ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

COPY . /app

ENV MONGO_INITDB_ROOT_USERNAME: root
ENV MONGO_INITDB_ROOT_PASSWORD: password

RUN npm install .


ENTRYPOINT ["/app/entrypoint.sh"]

