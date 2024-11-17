export GITHUB_USERNAME=anuragashok && \
curl https://bws.bitwarden.com/install | sh && \
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME