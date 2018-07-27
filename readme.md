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

### Vim - Denite 
I use Denite to handle the bulk of my vim work. I am still learning denite, but
it's been fantastic to use thus far. I have a few key mappings that I like to
use to optimize my Denite work

Again - prefix all the commands with `<Leader>`

```
  f = :DeniteProjectDir buffer file file_rec<CR>  
  s = :DeniteBufferDir  grep<CR><Esc>
  cw = :DeniteCursorWord grep:.<CR><Esc>
  ju = :DeniteProjectDir jump<CR>
  b = :Denite buffer<CR>
  ch = :DeniteProjectDir command_history<CR>
```

`f` acts as my fuzzy finder, within the project directory. I had it use
`file_mru` but I noticed it including files outside of my current directory, so
I opted out of it for now.

`s` is a way to search the buffer

`cw` will grep the word under the cursor

`ju` will jump to a tag

 `b` will trigger the buffer window
 
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

### Deoplete
I use deoplete for completion. It's working great, no config needed.

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

### Theme
  I just use the gruvbox theme, I don't really change it, and that way I only
  install that one theme, rather than having a hundred themes installed to
  change to.

### Plugins 
Aside from the plugins listed here, I have `vim-plug` setup to run them only
when triggered by the filetype. A JS plugin shouldn't run if you are writing
haskell and vice versa. 


