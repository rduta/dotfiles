if status is-interactive
	set -x PATH $HOME/.fzf/bin $PATH
	
	starship init fish | source
	fzf --fish | source
	source ~/.fzf-git/fzf-git.fish

end
