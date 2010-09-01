module YUITweets; module Config

# These words will be ignored by the Bayesian classifier.
STOPWORDS = Set.new(%w[
  1
  2
  3
  4
  5
  6
  7
  8
  9
  0
  #yui
  a
  about
  above
  across
  after
  afterwards
  again
  against
  ain't
  all
  almost
  alone
  along
  already
  also
  although
  always
  am
  among
  amongst
  amoungst
  amount
  an
  and
  another
  any
  anyhow
  anyone
  anything
  anyway
  anywhere
  are
  aren't
  around
  as
  at
  back
  be
  became
  because
  become
  becomes
  becoming
  been
  before
  beforehand
  behind
  being
  below
  beside
  besides
  between
  beyond
  both
  bottom
  but
  by
  can
  cannot
  can't
  co
  computer
  con
  could
  couldn't
  de
  describe
  detail
  did
  didn't
  do
  done
  don't
  down
  due
  during
  each
  eg
  either
  elsewhere
  empty
  enough
  etc
  even
  ever
  every
  everyone
  everything
  everywhere
  except
  few
  fill
  find
  fire
  first
  for
  found
  from
  front
  full
  further
  get
  give
  go
  had
  has
  hasn't
  have
  haven't
  he
  he's
  hence
  her
  here
  hereafter
  hereby
  herein
  hereupon
  hers
  hi
  him
  his
  how
  however
  i
  i'd
  if
  i'll
  i'm
  in
  inc
  indeed
  interest
  into
  is
  isn't
  it
  its
  it's
  i've
  keep
  last
  latter
  latterly
  least
  less
  ltd
  made
  many
  may
  me
  meanwhile
  might
  mine
  more
  moreover
  most
  mostly
  move
  much
  must
  mustn't
  my
  name
  namely
  neither
  never
  nevertheless
  next
  nine
  no
  nobody
  none
  noone
  nor
  not
  nothing
  now
  nowhere
  of
  off
  often
  oh
  on
  one
  only
  onto
  or
  other
  others
  otherwise
  our
  ours
  ourselves
  out
  over
  own
  part
  per
  perhaps
  please
  put
  rather
  re
  retweet
  rt
  same
  see
  seem
  seemed
  seeming
  seems
  several
  she
  she's
  should
  show
  side
  since
  sincere
  so
  some
  somehow
  someone
  something
  sometime
  sometimes
  somewhere
  still
  such
  take
  ten
  than
  that
  that's
  the
  their
  them
  themselves
  then
  thence
  there
  there's
  thereafter
  thereby
  therefore
  therein
  thereupon
  these
  they
  thick
  thin
  third
  this
  those
  though
  three
  through
  throughout
  thru
  thus
  to
  together
  too
  top
  toward
  towards
  tweet
  tweets
  twitter
  un
  under
  until
  up
  upon
  us
  very
  via
  was
  we
  well
  were
  what
  what's
  whatever
  when
  whence
  whenever
  where
  whereafter
  whereas
  whereby
  wherein
  whereupon
  wherever
  whether
  which
  while
  whither
  who
  whoever
  whole
  whom
  whose
  why
  will
  with
  within
  without
  won't
  would
  wouldn't
  yes
  yet
  you
  your
  you're
  yours
  yourself
  yourselves
  yui
  yui's
])

end; end
