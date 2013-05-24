#!/usr/bin/perl -w
# $Id:$
# $HeadURL:$
use strict;
use warnings;

use Carp;
use Getopt::Long;
Getopt::Long::Configure qw/bundling no_ignore_case/;
use Data::Dumper;
# Some Data::Dumper settings:
local $Data::Dumper::Useqq  = 1;
local $Data::Dumper::Indent = 3;
use Pod::Usage;

my $mydebug = 0;
my $dryrun  = 0;

GetOptions(
    "help|h"         => sub { pod2usage( 1 ); },
    "debug|d"        => \$mydebug,
    "dryrun|n"       => \$dryrun,
);

my $prog = $0;
$prog =~ s/^.*\///;

use MongoDB;

my $db_name   = 'machinedb';
my $coll_name = 'machines';
my $host = 'hydra';

my $client = MongoDB::MongoClient->new;
my $db = $client->get_database( $db_name );
my $machines = $db->get_collection( $coll_name );

#my $resp = $db->find( 'hostname' => qr/^$host\.*/msi );
#my $resp = $db->find_one( 'hostname' => qr/^$host\.*/msi );
my $resp = $machines->find_one({ 'hostname' => 
        { '$regex' => qr/$host\.*/msi }
    });

#my $ret = $ser->serialize( $resp );
print Dumper $resp;

__END__

