#!/usr/bin/env bash

## slock version
#PRED=$(printf "%b" "\x1b[38;2;175;95;95m")
#PYLW=$(printf "%b" "\x1b[38;2;175;135;95m")
#PBLU=$(printf "%b" "\x1b[38;2;135;135;135m")
#PPUR=$(printf "%b" "\x1b[38;2;175;135;135m")
#PCYN=$(printf "%b" "\x1b[38;2;135;175;175m")
#PWHT=$(printf "%b" "\x1b[38;2;223;223;175m")
#PGRY=$(printf "%b" "\x1b[38;2;98;98;98m")
#RST="\x1b[39m"

## Physlock version
PRED=$(printf "%b" "\e[1;31m")
PYLW=$(printf "%b" "\e[1;33m")
PBLU=$(printf "%b" "\e[1;34m")
PPUR=$(printf "%b" "\e[1;35m")
PCYN=$(printf "%b" "\e[1;36m")
PWHT=$(printf "%b" "\e[1;37m")
PGRY=$(printf "%b" "\e[90;1m")
PRST=$(printf "%b" "\e[0m")

# find the center of the screen
COL=274
ROW=83
((PADY = ROW / 2 - 52 / 2))
((PADYB = ROW - PADY - 39))
((PADX = COL / 2 - 95 / 2))

# top vertical padding
for ((i = 0; i < PADY; ++i)); do
	PADR="$PADR\n"
done

# bottom vertical padding
for ((i = 0; i < PADYB; ++i)); do
	PADRB="$PADRB\n "
done

# vertical padding
printf "%b" "$PADR"

PADX=$((PADX + 4))
for ((i = 0; i < PADX; ++i)); do
	PADC="$PADC "
done

PADXX=$((PADX + 9))
for ((i = 0; i < PADXX; ++i)); do
	PADCC="$PADCC "
done

cat <<EOF
$PADCC                            $PGRY==$PWHT(W{$PGRY==========-      $PRED/===-                        
$PADCC                              $PWHT||  $PWHT($PGRY.--.$PWHT)         $PRED/===-_---~~~~~~~~~------____  
$PADCC                              $PWHT| \_,$PGRY|$PPUR**$PGRY|$PWHT,__      $PRED|===-~___               $PGRY _,-' \`
$PADCC                 $PRED-==\\\        $PWHT\`\ ' $PGRY\`--'$PWHT   ),    $PRED\`//~\\\   ~~~~\`---.___.$PGRY-~~      
$PADCC             ${PRED}______-==|        $PBLU/$PWHT\`\_. .__/\ \    $PRED| |  \\\           ${PGRY}_-~\`         
$PADCC       ${PRED}__--~~~  ,-/-==\\\      $PBLU(   $PWHT| .  $PGRY|~~~~|   $PRED| |   \`\        $PGRY,'             
$PADCC    ${PRED}_-~       /'    |  \\\     $PBLU)__$PYLW/==0==-$PGRY\\$PCYN<>$PGRY/   $PRED/ /      \      $PGRY/               
$PADCC  $PRED.'        /       |   \\\      $PWHT/~$PYLW\___/$PWHT~~$PGRY\/  $PRED/' /        \   $PGRY/'                
$PADCC $PRED/ $PGRY ____$PRED  /         |    \`\.__/- $PWHT~~   \  |${PRED}_/'  /          \\$PGRY/'                  
$PADCC$PRED/$PGRY-'~    ~~~~~---__$PRED  |     ~-/~         $PWHT( )$PRED   /'        ${PGRY}_--~\`                   
$PADCC                  \_$PRED|      /        ${PGRY}_) $PWHT| ;  $PRED),   ${PGRY}__--~~                        
$PADCC                    '~~--_$PRED/      ${PGRY}_-~/- $PWHT|/$PGRY \   $PGRY'-~$PRED \                            
$PADCC                   $PGRY{\\${PRED}__--${PGRY}_/}    $PRED/ \\$PRED${PGRY}\_>-$PWHT|)$PGRY<__\      $PRED\                           
$PADCC                   /'   $PGRY(_/$PRED  _-~  | $PGRY|__>--<__|      $PRED|                          
$PADCC                  |   _${PPUR}/) $PRED)-~     | $PGRY|__>--<__|      $PRED|                          
$PADCC                  / /~ ,_/       / $PGRY/__>---<__/      $PRED|                          
$PADCC                 o-o _//        /$PGRY-~_>---<__-~      $PRED/                           
$PADCC                 (^(~          $PGRY/~_>---<__-      ${PRED}_-~                            
$PADCC                $PYLW,/|           $PGRY/__>--<__/     ${PRED}_-~                               
$PADCC             $PYLW,//('(          $PGRY|__>--<__|     $PRED/                  .----_          
$PADCC            $PRED($PYLW ( ')$PRED)          $PGRY|__>--<__|    $PRED|                 /' _---_~\        
$PADCC         $PRED\`-$PYLW)) ))$PRED (           $PGRY|__>--<__|    $PRED|               /'  /     ~\`\      
$PADCC        $PRED,/$PYLW,'//( $PRED(             $PGRY\__>--<__\    $PRED\            /'  $PGRY//        $PRED||      
$PADCC      $PRED,( $PYLW( ((, $PRED))              $PGRY~-__>--<_~-_  $PRED~--____---~' ${PGRY}_/'/        $PRED/'       
$PADCC    $PRED\`~/  $PYLW)\` ) $PRED,/|                 $PGRY~-_~>--<_/-__       __-~ _/                  
$PADCC  $PRED._-~$PYLW//( )/ $PRED)) \`                    $PGRY~~-'_/_/ /~~~~~~~__--~                    
$PADCC   $PRED;'$PYLW( ')/ $PRED,)(                              $PGRY~~~~~~~~~~                         
$PADCC  $PRED' ') $PYLW'( $PRED(/                                                                   
$PADCC    '   '  \`
$PRED
$PADC   @@@@@@@@@@  @@@  @@@  @@@@@@ @@@@@@@  @@@@@@@@ @@@      @@@  @@@ @@@@@@@@ @@@ @@@@@@@@@@ 
$PADC   @@! @@! @@! @@!  @@@ !@@     @@!  @@@ @@!      @@!      @@!  @@@ @@!      @@! @@! @@! @@!
$PADC   @!! !!@ @!@ @!@  !@!  !@@!!  @!@@!@!  @!!!:!   @!!      @!@!@!@! @!!!:!   !!@ @!! !!@ @!@
$PADC   !!:     !!: !!:  !!!     !:! !!:      !!:      !!:      !!:  !!! !!:      !!: !!:     !!:
$PADC    :      :    :.:: :  ::.: :   :       : :: ::: : ::.: :  :   : : : :: ::: :    :      :  
$PRST                                                                                          
EOF
echo -e "$PADRB"
