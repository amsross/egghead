FROM node:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim tmux zsh git jq locales

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get remove -y vim
RUN apt-get autoremove -y
WORKDIR /root
RUN git clone https://github.com/vim/vim.git
WORKDIR /root/vim
RUN git checkout v8.1.1855
WORKDIR /root/vim/src
RUN make
RUN make install

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

WORKDIR /root

# vim plugins
RUN mkdir -p /root/.vim/autoload /root/.vim/bundle
RUN curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# defaults
RUN git clone git://github.com/tpope/vim-sensible.git /root/.vim/bundle/vim-sensible
# comments
RUN git clone git://github.com/tpope/vim-commentary.git /root/.vim/bundle/vim-commentary
# JS syntax highlighting
RUN git clone https://github.com/jelera/vim-javascript-syntax.git /root/.vim/bundle/vim-javascript-syntax
# JS indentation
RUN git clone https://github.com/gavocanov/vim-js-indent.git /root/.vim/bundle/vim-js-indent
# GraphQL highlighting
RUN git clone https://github.com/jparise/vim-graphql.git /root/.vim/bundle/vim-graphql

COPY ./.vimrc /root/.vimrc
COPY ./.zshrc /root/.zshrc
COPY ./.tmux.conf /root/.tmux.conf

RUN mkdir -p /code
WORKDIR /code

RUN chsh -s /bin/zsh

ENTRYPOINT tmux
