Perl library which provides API for PID-file manipulations
==========================================================

Example:
--------
```
use Run::PidFile;

# Create Run::PidFile object.
my $pidh = Run::PidFile->new('my_pid_file.pid');
# Create Run::PidFile object and open pid file.
my $pidh = Run::PidFile->new('my_pid_file.pid', Open => 1) or die "Can't create and lock PID-file: $!\n";
# Create Run::PidFile object with non-blocking locking by default.
my $pidh = Run::PidFile->new('my_pid_file.pid', Nonblock => 1);

# Create pid-file, lock it and write the calling process pid into the file.
$pidh->open();
# The same as above in non-blocking mode.
$pidh->open(Nonblock => 1) or die "Can't create and lock PID-file: $!\n";

# Close and unlock the file.
$pidh->close();
# The same as above with unlinking the file after closing it.
$pidh->close(Unlink => 1);
```
