### Ryan's Dotfiles
Here are my dotfiles - these tend to change regularly. I am always tweaking
these, trying to perfect it to be better, and as I learn more, I hope I do that.

Please use at your own risk.

### Leader

My leader key is Space.

### Vim - Git
I use vim-fugitive to handle my git work while working in vim. I have setup
a few key mappings to make my git workflow a bit faster. 


All of the keys are prefixed by the `<Leader>` key.

```
gaa = git add .
gp = git push  
gs = git status
gc = git commit
gca = git commit -- amend
gb = git blame
```
### FZF 
 FZF is love, its literally an incredible tool

 ```
  <Leader> f  = files
  <Leader> g = Git files
  <Leader><Leader> = Recent Files
  <Leader> C = Commits
  <Leader> c = Commands
  <Leader> ; = Buffer lines
  <Leader> T = Tags
  <Leader> t = Buffer Tags
  <Leader> H = history
  <Leader> s = grep file
  <Leader> S = grep cursor word
  <Leader> b = buffers
 ```
### Dash - vim
 I work on OSX currently, and have Dash installed. So here are my current key
 mappings to use Dash with vim.

 Again - prefix with `<Leader>`

 ```
  ds = Dash search, will search under cursor  
  da = will search dash - expecting arguments library:term
 ```

### Ale
I use Ale for linting, and fixing. I have it configured for Prettier in
javascript/typescript. I also have it fix on  save.

Haskell - I am trying out brittany

### YouCompleteMe
YoucompleteMe works best for me, so i use it.


### Intero
 Again - all commands are prefixed with `<Leader>`
  
 ```
  is : InteroStart
  ik : InteroKill
  io : InteroOpen
  iov : InteroOpen
  ih : InteroHide
  il : InteroLoadCurrentModule
  if : InteroLoadCurrentFile
  t : InteroGenericType
  T : InteroType
  it : InteroTypeInsert
  jd : InteroGoToDef
 ```

### Lightline
  I've tried airline - I just found Lightline to be far faster. I don't need any
  special stuff, I included vim-fugitive and it works on the powerline theme by
  default

### Plugins 
Aside from the plugins listed here, I have `vim-plug` setup to run them only
when triggered by the filetype. A JS plugin shouldn't run if you are writing
haskell and vice versa. 


