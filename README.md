# **p2pcheck**
------------


## Check if your **SABnzbd+** plugins are running and available
 * some features or all features will only work on **OS X 10.8** (notification center)
 * I have all my sab plugins started with launchd, you will have to edit the execute option for terminal-notifier  https://github.com/alloy/terminal-notifier to fit ur needs. I wanted the option of restarting via the "lunchy" gem https://github.com/mperham/lunchy
e.g. My sabnzbd launchd plist is named com.tv.Sabnzbd.plist, so this is my terminal-notifier line , ```		TerminalNotifier.notify("#{reachable}\n#{message}", :title =>"Attention!", :execute => "lunchy restart com.tv.#{name.downcase}")```
 * make a config file named ".p2pcheck" and place in ur home directory, see the sample provided

check out [My Github Page](http://capybara.github.com/p2pcheck)