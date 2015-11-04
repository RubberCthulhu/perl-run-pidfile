
package Run::PidFile;
use strict;
use warnings;
use IO::File;
require Exporter;
use Fcntl qw(:flock LOCK_EX LOCK_NB);

our @ISA = qw(IO::File Exporter);

sub new {
    my ($class, $path, %opt) = @_;

    my $self = $class->SUPER::new or return;
    ${*$self}{Path} = $path;
    ${*$self}{Nonblock} = $opt{Nonblock} // 0;

    return $self->open if $opt{Open};

    return $self;
}

sub open {
    my ($self, %opt) = @_;

    my $nonblock = exists $opt{Nonblock} ? $opt{Nonblock} : ${*$self}{Nonblock};
    $self->SUPER::open(${*$self}{Path}, '>>') or return;
    if( flock($self, LOCK_EX | ($nonblock ? LOCK_NB : 0)) ) {
        $self->truncate(0);
        $self->syswrite("$$");
    }
    else {
        $self->close;
        return;
    }

    return $self;
}

sub close {
    my ($self, %opt) = @_;

    $self->SUPER::close();
    unlink ${*$self}{Path} if $opt{Unlink};

    return $self;
}

1;
