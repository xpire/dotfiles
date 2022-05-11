function svim
    docker run -it -v $(pwd):/home/spacevim/src -v ~/.SpaceVim.d:/home/spacevim/.SpaceVim.d --rm spacevim/spacevim nvim
end
