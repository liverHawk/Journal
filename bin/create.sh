function write_success() {
    echo -e "[\e[32m+\e[0m] $1"
}

function write_error() {
    echo -e "[\e[31m!\e[0m] $1"
}

# write_success "Creating daily journal entry..."
# write_error "An error occurred while creating the journal entry."

words=("will" "care" "freeze" "realize" "roof" "me" "variable" "glory" "courage" "boat" "unrest" "slip" "switch" "scrape" "censorship" "flower")
random_word=${words[RANDOM % ${#words[@]}]}

# echo "Random word selected: $random_word"
origin_path=$(pwd)

# if path is */bin
if [[ $origin_path == */bin ]]; then
    path=$(dirname "$origin_path")
else
    path=$origin_path
fi

# echo "Current path: $path"

year=$(date +%Y)
month=$(date +%m)
en_month=$(LANG=en_US date +%B)
en_month=$(echo "$en_month" | tr '[:upper:]' '[:lower:]')

# exists "$path/01_daily/$year"?
if [[ ! -d "$path/01_daily/$year" ]]; then
    mkdir -p "$path/01_daily/$year"
fi

# echo "$month"
full_month="$month""_$en_month"
# echo "Full month: $full_month"

if [[ ! -d "$path/01_daily/$year/$full_month" ]]; then
    mkdir -p "$path/01_daily/$year/$full_month"
fi

path="$path/01_daily/$year/$full_month"

date_st=$(date +%d)

matching_files=("$path/$date_st"*.adoc)
if [[ ! -e "${matching_files[0]}" ]]; then
    file_name="${date_st}_$random_word.adoc"
    write_success "Creating file: $file_name"
    touch "$path/$file_name"
else
    file_name=$(basename "${matching_files[0]}")
    write_error "File already exists: $file_name"
fi