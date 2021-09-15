#!/usr/bin/env bash

PBLK="\e[1;30m"
PRED="\e[1;31m"
PGRN="\e[1;32m"
PYLW="\e[1;33m"
PBLU="\e[1;34m"
PPUR="\e[1;35m"
PCYN="\e[1;36m"
PWHT="\e[1;37m"
PGRY="\e[90;1m"
PRST="\e[0m"

# find the center of the screen
COL=274
ROW=83
((PADY = ROW / 2 - 52 / 2))
((PADYB = ROW - PADY - 46))
((PADX = COL / 2 - 95 / 2))

for ((i = 0; i < PADX; ++i)); do
	PADC="$PADC "
done

for ((i = 0; i < PADY; ++i)); do
	PADR="$PADR\n"
done

# bottom vertical padding
for ((i = 0; i < PADYB; ++i)); do
	PADRB="$PADRB\n "
done

# vertical padding
printf "%b" "$PADR"

PADXX=$((PADX + 9))
for ((i = 0; i < PADXX; ++i)); do
	PADCC="$PADCC "
done

#PADXXX=$((PADX - 35))
#for ((i = 0; i < PADXXX; ++i)); do
#	PADCCC="$PADCCC "
#done

cat <<EOF
$PADCC                          $PGRY==$PWHT(W{$PGRY==========-      $PRED/===-                        
$PADCC                             $PWHT||  $PWHT($PGRY.--.$PWHT)         $PRED/===-_---~~~~~~~~~------____  
$PADCC                             $PWHT| \\\_,$PGRY|$PPUR**$PGRY|$PWHT,__      $PRED|===-~___               $PGRY _,-' \`
$PADCC                 $PRED-==\\\        $PWHT\`\\\ ' $PGRY\`--'$PWHT   ),    $PRED\`//~\\\   ~~~~\`---.___.$PGRY-~~      
$PADCC            ${PRED}______-==|        $PBLU/$PWHT\`\\\_. .__/\\\ \\\    $PRED| |  \\\           ${PGRY}_-~\`         
$PADCC       ${PRED}__--~~~  ,-/-==\\\      $PBLU(   $PWHT| .  $PGRY|~~~~|   $PRED| |   \`\\\        $PGRY,'             
$PADCC    ${PRED}_-~       /'    |  \\\     $PBLU)__$PYLW/==0==-$PGRY\\\\$PCYN<>$PGRY/   $PRED/ /      \\\      $PGRY\\\/               
$PADCC  $PRED.'        /       |   \\\      $PWHT/~$PYLW\\\___/$PWHT~~$PGRY\\\/  $PRED/' /        \\\   $PGRY/'                
$PADCC $PRED/ $PGRY ____$PRED  /         |    \`\\\.__/- $PWHT~~   \\\  |${PRED}_/'  /          \\\\$PGRY/'                  
$PADCC$PRED/$PGRY-'~    ~~~~~---__$PRED  |     ~-/~         $PWHT( )$PRED   /'        ${PGRY}_--~\`                   
$PADCC                  \\\_$PRED|      /        ${PGRY}_) $PWHT| ;  $PRED),   ${PGRY}__--~~                        
$PADCC                    '~~--_$PRED/      ${PGRY}_-~/- $PWHT|/$PGRY \\\   $PGRY'-~$PRED \\\                            
$PADCC                   $PGRY{\\\\${PRED}__--${PGRY}_/}    $PRED/ \\\\$PRED${PGRY}\\\_>-$PWHT|)$PGRY<__\\\      $PRED\\\                           
$PADCC                   /'   $PGRY(_/$PRED  _-~  | $PGRY|__>--<__|      $PRED|                          
$PADCC                  |   _${PPUR}/) $PRED)-~     | $PGRY|__>--<__|      $PRED|                          
$PADCC                  / /~ ,_/       / $PGRY/__>---<__/      $PRED|                          
$PADCC                 o-o _//        /$PGRY-~_>---<__-~      $PRED/                           
$PADCC                 (^(~          $PGRY/~_>---<__-      ${PRED}_-~                            
$PADCC                $PYLW,/|           $PGRY/__>--<__/     ${PRED}_-~                               
$PADCC             $PYLW,//('(          $PGRY|__>--<__|     $PRED/                  .----_          
$PADCC            $PRED($PYLW ( ')$PRED)          $PGRY|__>--<__|    $PRED|                 /' _---_~\\\        
$PADCC         $PRED\`-$PYLW)) ))$PRED (           $PGRY|__>--<__|    $PRED|               /'  /     ~\`\\\      
$PADCC        $PRED,/$PYLW,'//( $PRED(             $PGRY\\\__>--<__\\\    $PRED\\\            /'  $PGRY//        $PRED||      
$PADCC      $PRED,( $PYLW( ((, $PRED))              $PGRY~-__>--<_~-_  $PRED~--____---~' ${PGRY}_/'/        $PRED/'       
$PADCC    $PRED\`~/  $PYLW)\` ) $PRED,/|                 $PGRY~-_~>--<_/-__       __-~ _/                  
$PADCC  $PRED._-~$PYLW//( )/ $PRED)) \`                    $PGRY~~-'_/_/ /~~~~~~~__--~                    
$PADCC   $PRED;'$PYLW( ')/ $PRED,)(                              $PGRY~~~~~~~~~~                         
$PADCC  $PRED' ') $PYLW'( $PRED(/                                                                   
$PADCC    '   '  \`
$PRE
$PADC  @@@  @@@  @@@ @@@@@@@@ @@@       @@@@@@@  @@@@@@  @@@@@@@@@@  @@@@@@@@      @@@@@@@  @@@@@@ 
$PADC  @@!  @@!  @@! @@!      @@!      !@@      @@!  @@@ @@! @@! @@! @@!             @@!   @@!  @@@
$PADC  @!!  !!@  @!@ @!!!:!   @!!      !@!      @!@  !@! @!! !!@ @!@ @!!!:!          @!!   @!@  !@!
$PADC   !:  !!:  !!  !!:      !!:      :!!      !!:  !!! !!:     !!: !!:             !!:   !!:  !!!
$PADC    ::.:  :::   : :: ::: : ::.: :  :: :: :  : :. :   :      :   : :: :::         :     : :. : 
$PADC                                                                                              
$PADC   @@@@@@@@@@  @@@  @@@  @@@@@@ @@@@@@@  @@@@@@@@ @@@      @@@  @@@ @@@@@@@@ @@@ @@@@@@@@@@ 
$PADC   @@! @@! @@! @@!  @@@ !@@     @@!  @@@ @@!      @@!      @@!  @@@ @@!      @@! @@! @@! @@!
$PADC   @!! !!@ @!@ @!@  !@!  !@@!!  @!@@!@!  @!!!:!   @!!      @!@!@!@! @!!!:!   !!@ @!! !!@ @!@
$PADC   !!:     !!: !!:  !!!     !:! !!:      !!:      !!:      !!:  !!! !!:      !!: !!:     !!:
$PADC    :      :    :.:: :  ::.: :   :       : :: ::: : ::.: :  :   : : : :: ::: :    :      :  
$PRST                                                                                          
$PAD                  
EOF
echo -e "$PADRB"
