# Socialmine Tester
This is what I use to add people to socialmine and rank them up for testing.

The code is all in one directory, but it all starts and gets ran in the driver.rb file. It is commented to show the different tests that I do.

I use the following in my vimrc to allow tslime to send commands to a tmux window similar
to how hashrocket uses leader-t for testing.

```vim
function! RunFileWithRuby()
  w
  let fname = @%
  let command =  "ruby ".fname."\n"
  call Send_to_Tmux(command)
endfunction
map <leader>r :call RunFileWithRuby()<cr>
```
