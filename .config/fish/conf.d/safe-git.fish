# git の危険な補完を無効化
complete -c git -n '__fish_seen_subcommand_from push' -l force -e
complete -c git -n '__fish_seen_subcommand_from reset' -l hard -e
complete -c git -n '__fish_seen_subcommand_from clean' -s f -e
complete -c git -n '__fish_seen_subcommand_from clean' -s d -e

