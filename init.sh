export GITHUB_USERNAME=anuragashok && \
export PATH="$PATH:$HOME/.local/bin" && \
curl https://bws.bitwarden.com/install | sh && \
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
