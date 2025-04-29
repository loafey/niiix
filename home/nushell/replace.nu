def replace [...args] {
    let stdin = each { |in| $in } | str join "\n"
    mut newArgs = []
    mut i = 0; 
    loop { 
        if $i + 1 > ($args | length) { break }; 
        let a = $args | get $i
        let b = $args | get ($i + 1)
        $newArgs = $newArgs | append [$a, $b]
        $i = $i + 2
    }
    echo $newArgs
    # echo "#define replaceMe swaggot\nhello i am replaceMe" | gcc -E -S -
}