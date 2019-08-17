FROM node:latest

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y tmux zsh git jq locales && \
  apt-get autoremove -y && \
  apt-get clean && \
  apt-get autoclean

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && \
  export LANG=en_US.UTF-8 && \
  export LANGUAGE=en_US:en && \
  export LC_ALL=en_US.UTF-8

WORKDIR /root

# install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# install vim
RUN git clone https://github.com/vim/vim.git && \
  cd /root/vim && \
  git checkout v8.1.1855 && \
  cd /root/vim/src && \
  make && \
  make install && \
  make clean

WORKDIR /root

# vim plugins
RUN mkdir -p /root/.vim/autoload /root/.vim/bundle && curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
# defaults
  git clone git://github.com/liuchengxu/vim-better-default /root/.vim/bundle/vim-better-default && \
# comments
  git clone git://github.com/tpope/vim-commentary.git /root/.vim/bundle/vim-commentary && \
# JS syntax highlighting
  git clone https://github.com/jelera/vim-javascript-syntax.git /root/.vim/bundle/vim-javascript-syntax && \
# JS indentation
  git clone https://github.com/gavocanov/vim-js-indent.git /root/.vim/bundle/vim-js-indent && \
# GraphQL highlighting
  git clone https://github.com/jparise/vim-graphql.git /root/.vim/bundle/vim-graphql && \
# ReasonML
  git clone https://github.com/reasonml-editor/vim-reason-plus.git /root/.vim/bundle/vim-reason-plus && \
# LSP
  git clone https://github.com/autozimu/LanguageClient-neovim /root/.vim/bundle/LanguageClient-neovim && \
    cd /root/.vim/bundle/LanguageClient-neovim && \
    ./install.sh

COPY ./reason-language-server /root/reason-language-server
COPY ./.vimrc /root/.vimrc
COPY ./.zshrc /root/.zshrc
COPY ./.tmux.conf /root/.tmux.conf

RUN chsh -s /bin/zsh && \
  mkdir -p /code

WORKDIR /code

ENTRYPOINT tmux
