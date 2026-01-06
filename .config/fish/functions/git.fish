function git
    if string match -rq '.*--force' -- $argv
        read -P "⚠️  REALLY run 'git --force'? (yes/no) " ans
        test "$ans" = yes; or return 1
    end
    command git $argv
end

