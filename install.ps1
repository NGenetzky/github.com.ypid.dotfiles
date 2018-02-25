## Just copy the files in place. Seems nobody using windows ever heard about a dotfiles manager nor git* so this is what I ended up with.
## *git is now Microsoft default so forget about that last part :)

function cp--no-clobber{
    Param(
        [parameter(Mandatory=$true)][String]$source,
        [parameter(Mandatory=$true)][String]$dest
    )

    if ((test-path $dest) -bxor 1) {
        echo "cp $source $dest"
        cp $source $dest
    }
}

function link_path{
    Param(
        [parameter(Mandatory=$true)][String]$source,
        [parameter(Mandatory=$true)][String]$dest
    )

    rm "$dest"
    if ((test-path $dest) -bxor 1) {
        echo new-hardlink "$dest" "$source"
        # new-hardlink "$dest" "$source"
        new-item -Path "$dest" -ItemType SymbolicLink -Value "$source" | Out-Null
    }
}

$documents_path = [environment]::getfolderpath("mydocuments")

## I am using forward slashes. Get used to it Windows guys.
link_path "./windows/MS_Shell/" "$documents_path/WindowsPowerShell"
link_path "./vimrc.min" ~/_vimrc
link_path "./windows/ConEmu/ConEmu.xml" "$env:APPDATA/ConEmu.xml"
link_path "./gitconfig" ~/.gitconfig
mkdir -f "$env:APPDATA/VirtuaWin" > $null
link_path "./windows/VirtuaWin/virtuawin.cfg" "$env:APPDATA/VirtuaWin/virtuawin.cfg"

mkdir -f "$env:APPDATA/obs-studio/basic/profiles/Untitled" > $null
## OBS Studio v20.1.3 can not handle these kinds of symlinks. It will overwrite them.
# link_path "./config/obs-studio/basic/profiles/Untitled/basic.ini" "$env:APPDATA/obs-studio/basic/profiles/Untitled/basic.ini"
cp--no-clobber "./config/obs-studio/basic/profiles/Untitled/basic.ini" "$env:APPDATA/obs-studio/basic/profiles/Untitled/basic.ini"

mkdir -f "$env:APPDATA/doublecmd/" > $null
link_path "./doublecmd/shortcuts.scf" "$env:APPDATA/doublecmd/shortcuts.scf"
cp--no-clobber "./doublecmd/sanitize_doublecmd_xml" "$env:APPDATA/doublecmd/doublecmd.xml"

mkdir -f "$env:APPDATA/Neo2/" > $null
link_path "./qNeo2/Neo2.ini" "$env:APPDATA/Neo2/Neo2.ini"

mkdir -f "$documents_path//portable/kitty/Sessions/" > $null
link_path "./windows/kitty/Sessions/Default%20Settings" "$documents_path/portable/kitty/Sessions/Default%20Settings"
link_path "./windows/kitty/kitty.ini" "$documents_path/portable/kitty/kitty.ini"

link_path "$documents_path/dotfiles/startup/startup.bat" "$env:APPDATA/Microsoft/Windows/Start Menu/Programs/Startup/startup.bat"

Install-Module -Name ZLocation
Install-Module -Name Pscx -Force -AllowClobber
# Install-Module -Name PSReadLine -Force
