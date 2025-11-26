#!/bin/sh

deckAddr=https://github.com/hoss-java/lessons/blob/main/DECK.md
# check commit-msg
msgline=$1
msgpattern='['[wW]*[0-9]-[cC]*[0-9]']'*
case $msgline in
  $msgpattern) ;;
  *)
	echo "A message should be start with a pattern like [W<week-number>-C<card-number>]"
  	exit 1;;
esac

# Create a link to the deck card
commentStr=$(eval echo "$1" | sed "s/.*]//")
deckIdBlock=$(eval echo "$1" | sed "s/$commentStr//g")
deckIdStr=$(eval echo "$deckIdBlock" | sed -e 's/^.//' -e 's/.$//')

deckWeekId=$(eval echo "$deckIdStr" | sed "s/.*-//")
deckWeekId=$(eval echo "$deckIdStr" | sed "s/$deckCardId//g")


deckCardId=$(eval echo "$deckCardId" | sed -e 's/^.//')
deckWeekId=$(eval echo "$deckBoardId" | sed -e 's/^.//' -e 's/.$//')

echo "$deckAddr#$deckWeekId-$deckCardId"
