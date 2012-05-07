# Socialmine Tester
This is what I use to add people to socialmine for testing.

It is not very well commented since I made it only for me for testing and it just kept growing as I needed to test different scenarios.

The code is not really organized either, but it all starts and gets ran in the driver.rb file. It is commented to show the different tests that I do.

I use the following in my vimrc to allow tslime to send commands to a tmux window similar
to how hashrocket uses leader-t for testing.

```vim
map <leader>a :call Send_to_Tmux("rake\n")<cr>
function! RunFileWithRuby()
  w
  let fname = @%
  let command =  "ruby ".fname."\n"
  call Send_to_Tmux(command)
endfunction
map <leader>r :call RunFileWithRuby()<cr>
```
