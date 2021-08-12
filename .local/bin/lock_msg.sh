#!/usr/bin/env bash

PRED=$(printf "%b" "\x1b[38;2;175;95;95m")
PYLW=$(printf "%b" "\x1b[38;2;175;135;95m")
PBLU=$(printf "%b" "\x1b[38;2;135;135;135m")
PPUR=$(printf "%b" "\x1b[38;2;175;135;135m")
PCYN=$(printf "%b" "\x1b[38;2;135;175;175m")
PWHT=$(printf "%b" "\x1b[38;2;223;223;175m")
PGRY=$(printf "%b" "\x1b[38;2;98;98;98m")
PBLD=$(printf "%b" "\033[1m")
RST="\x1b[39m"

#PADC="            "
PADC=""

cat <<EOF
                            $PGRY==$PWHT(W{$PGRY==========-      $PRED/===-                        
                              $PWHT||  $PWHT($PGRY.--.$PWHT)         $PRED/===-_---~~~~~~~~~------____  
                              $PWHT| \_,$PGRY|$PPUR**$PGRY|$PWHT,__      $PRED|===-~___               $PGRY _,-' \`
                 $PRED-==\\\        $PWHT\`\ ' $PGRY\`--'$PWHT   ),    $PRED\`//~\\\   ~~~~\`---.___.$PGRY-~~      
             ${PRED}______-==|        $PBLU/$PWHT\`\_. .__/\ \    $PRED| |  \\\           ${PGRY}_-~\`         
       ${PRED}__--~~~  ,-/-==\\\      $PBLU(   $PWHT| .  $PGRY|~~~~|   $PRED| |   \`\        $PGRY,'             
    ${PRED}_-~       /'    |  \\\     $PBLU)__$PYLW/==0==-$PGRY\\$PCYN<>$PGRY/   $PRED/ /      \      $PGRY/               
  $PRED.'        /       |   \\\      $PWHT/~$PYLW\___/$PWHT~~$PGRY\/  $PRED/' /        \   $PGRY/'                
 $PRED/ $PGRY ____$PRED  /         |    \`\.__/-$PWHT~~   \  |${PRED}_/'  /           \/$PGRY'                  
$PRED/$PGRY-'~    ~~~~~---__$PRED  |     ~-/~         $PWHT( )$PRED   /'        ${PGRY}_--~\`                   
                  \_$PRED|      /        ${PGRY}_) $PWHT| ;  $PRED),   ${PGRY}__--~~                        
                    '~~--_$PRED/      ${PGRY}_-~/- $PWHT|/$PGRY \   $PGRY'-~$PRED \                            
                   $PGRY{\\${PRED}__--${PGRY}_/}    $PRED/ \\$PRED${PGRY}\_>-$PWHT|)$PGRY<__\      $PRED\                           
                   /'   $PGRY(_/$PRED  _-~  | $PGRY|__>--<__|      $PRED|                          
                  |   _${PPUR}/) $PRED)-~     | $PGRY|__>--<__|      $PRED|                          
                  / /~ ,_/       / $PGRY/__>---<__/      $PRED|                          
                 o-o _//        /$PGRY-~_>---<__-~      $PRED/                           
                 (^(~          $PGRY/~_>---<__-      ${PRED}_-~                            
                $PYLW,/|           $PGRY/__>--<__/     ${PRED}_-~                               
             $PYLW,//('(          $PGRY|__>--<__|     $PRED/                  .----_          
            $PRED($PYLW ( ')$PRED)          $PGRY|__>--<__|    $PRED|                 /' _---_~\        
         $PRED\`-$PYLW)) ))$PRED (           $PGRY|__>--<__|    $PRED|               /'  /     ~\`\      
        $PRED,/$PYLW,'//( $PRED(             $PGRY\__>--<__\    $PRED\            /'  $PGRY//        $PRED||      
      $PRED,( $PYLW( ((, $PRED))              $PGRY~-__>--<_~-_  $PRED~--____---~' ${PGRY}_/'/        $PRED/'       
    $PRED\`~/  $PYLW)\` ) $PRED,/|                 $PGRY~-_~>--<_/-__       __-~ _/                  
  $PRED._-~$PYLW//( )/ $PRED)) \`                    $PGRY~~-'_/_/ /~~~~~~~__--~                    
   $PRED;'$PYLW( ')/ $PRED,)(                              $PGRY~~~~~~~~~~                         
  $PRED' ') $PYLW'( $PRED(/                                                                   
    '   '  \`

$PRED@@@@@@@   @@@@@@   @@@@@@  @@@@@@ @@@  @@@  @@@  @@@@@@  @@@@@@@  @@@@@@@    
@@!  @@@ @@!  @@@ !@@     !@@     @@!  @@!  @@! @@!  @@@ @@!  @@@ @@!  @@@ @@
@!@@!@!  @!@!@!@!  !@@!!   !@@!!  @!!  !!@  @!@ @!@  !@! @!@!!@!  @!@  !@!   
!!:      !!:  !!!     !:!     !:!  !:  !!:  !!  !!:  !!! !!: :!!  !!:  !!! !!
 :        :   : : ::.: :  ::.: :    ::.:  :::    : :. :   :   : : :: :  :    

EOF
