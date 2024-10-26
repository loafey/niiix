cd ~/Git/niiix
git pull
nix flake update
#cd git-flakes/
#cd stremio
#nix flake update
#cd ..
#cd klassy
#nix flake update
#cd ..
#git add .
#try {
#    git add stremio/flake.lock
#    git add klassy/flake.lock
#    # git add git-flakes/flake.lock
#    let s = ["\"[System Update] ", (date now | format date "%Y-%m-%d %H:%M"),"\""] | str join
#    git commit -m $s
#    git push
#}
#cd ..
nh os switch .
# stinky goodness
try {
    git add flake.lock
    # git add git-flakes/flake.lock
    let s = ["\"[System Update] ", (date now | format date "%Y-%m-%d %H:%M"),"\""] | str join
    git commit -m $s
    git push
}
print "- collecting garbage -"
let before = df -h
#try {
#    bash ~/Git/niiix/clean_user.sh
#}
nix-collect-garbage -d --delete-old
sudo nix-collect-garbage -d --delete-old

print "- linking -"
sudo nix-store --optimise

let after = df -h

print " - Before - "
print $before
print " - After - "
print $after
