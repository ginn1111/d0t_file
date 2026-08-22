function gh_s
    set base_url "https://api.github.com/search/repositories?q="
    set query (string replace -a " " "+" -- $argv)

    curl -s "$base_url$query" | jq '.items[].html_url'
end
