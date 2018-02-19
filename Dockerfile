FROM node:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim tmux zsh git
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

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

COPY ./.vimrc /root/.vimrc
COPY ./.zshrc /root/.zshrc
COPY ./.tmux.conf /root/.tmux.conf

RUN mkdir -p /code
WORKDIR /code

RUN chsh -s /bin/zsh

ENTRYPOINT tmux
