# cryptozombies

My progress on the cryptozombies.io course.

## notes

Install (download) solang. Just google it. It serves as our language server for solidity.

Since we're using coc.vim in neovim, we need to extend our coc-settings.json like so:

1. Open it via the `:CocConfig` command
2. Add the following snippet:


```json
    "solidity": {
            "command": "/home/rs/bin/solang-linux",
            "args": [ "--language-server" ],
            "trace.server": "verbose",
            "rootPatterns": [".git/"],
            "filetypes": ["solidity"]
        }
```


