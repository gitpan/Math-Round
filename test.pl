# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

################## We start with some black magic to print on failure.

BEGIN { $| = 1; print "1..7\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Round qw(:all);
$loaded = 1;
print "ok 1\n";

################## End of black magic.

my $failed = 0;

#--- Both scalar and list contexts are tested.
print "round............";
was_it_ok(2, round(2.4) == 2 &&
  round(2.5) == 3 &&
  round(2.6) == 3 &&
  eq2(round(-3.9, -2.5), -4, -3) );

print "round_even.......";
was_it_ok(3, round_even(2.4) == 2 &&
  round_even(2.5) == 2 &&
  eq2(round_even(-2.6, 3.5), -3, 4) );

print "round_odd........";
was_it_ok(4, round_odd(16.4) == 16 &&
  round_odd(16.5) == 17 &&
  round_odd(16.6) == 17 &&
  eq2(round_odd(-16.7, 17.5), -17, 17) );

print "round_rand.......";
was_it_ok(5, round_rand(16.4) == 16 &&
  round_rand(16.6) == 17 &&
  eq2(round_rand(-17.8, -29.2), -18, -29) );

print "nearest..........";
was_it_ok(6, nearest(20, 9) == 0 &&
  nearest(20, 10) == 20 &&
  nearest(20, 11) == 20 &&
  sprintf("%.2f", nearest(0.01, 16.575)) eq "16.58" &&
  eq2(nearest(20, -98, -110), -100, -120) );

print "nearest_rand.....";
was_it_ok(7, nearest_rand(30, 44) == 30 &&
  nearest_rand(30, 46) == 60 &&
  eq2(nearest_rand(30, -76, -112), -90, -120) );

if ($failed == 0) { print "All tests successful.\n"; }
else {
   $tt = ($failed == 1) ? "1 test" : "$failed tests";
   print "$tt failed!  There is no joy in Mudville.\n";
}


#--- Compare two lists with 2 elements each for equality.
sub eq2 {
 my ($a0, $a1, $b0, $b1) = @_;
 return ($a0 == $b0 && $a1 == $b1) ? 1 : 0;
}

sub was_it_ok {
 my ($num, $test) = @_;
 if ($test) { print "ok $num\n"; }
 else       { print "not ok $num\n"; $failed++; }
}
