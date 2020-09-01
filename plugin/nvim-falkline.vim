" TODO: Git stats in git blob
" Falkline {{{
" NOTE: Might also be set in RedrawModeColors!
call g:HL( 'StatusLine'             , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'StatusLineNC'           , 'black'      , 'none'       , 'bold'   )
call g:HL( 'FalklineSeparator'      , 'dark_fg'    , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineModified'       , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineFiletype'       , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineFiletypeBody'   , 'white'      , 'mid_dark'   , 'italic' )
call g:HL( 'FalklinePercentage'     , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklinePercentageBody' , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineGit'        , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineLineGitBody'    , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineGitSymbol'  , 'white'      , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineCol'        , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineLineColBody'    , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineAleOkBody'      , 'white'      , 'green'      , 'bold'   )
call g:HL( 'FalklineAleWarningBody' , 'red'        , 'yellow'     , 'bold'   )
call g:HL( 'FalklineAleErrorBody'   , 'white'      , 'red'        , 'bold'   )
call g:HL( 'FalklineAleSpacer'      , 'red'        , 'yellow'     , 'none'   )
" Primary and secondary colours, changed in RedrawModeColors()
let g:FalklineMainA = 'mid_dark'
let g:FalklineMainB = 'none'
let g:FalklineNLine = 'soft_dark'
" Falkline }}}
" Statusline {{{
" Prerequisite Settings {{{
set noshowmode
set laststatus=2
" Prerequsite Settings }}}
" Functions {{{
" ALE Functions {{{
function! GetMaybeAleOK() abort " {{{
   let l:counts      =  ale#statusline#Count(bufnr(''))
   if l:counts.total == 0
      call g:HL( 'FalklineAleLeft'  , 'green' , g:FalklineMainB , 'none' )
      call g:HL( 'FalklineAleRight' , 'green' , g:FalklineMainB , 'none' )
   endif
   return ''
endfunction " }}}
function! GetMaybeAleErrors() abort " {{{
   let l:counts         = ale#statusline#Count(bufnr(''))
   let l:all_errors     = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   if l:all_errors > 0
      call g:HL( 'FalklineAleLeft' , 'red' , g:FalklineMainB , 'none' )
      if l:all_non_errors == 0
         call g:HL( 'FalklineAleRight' , 'red' , g:FalklineMainB , 'none' )
      endif
      return printf("%d", l:all_errors)
   else
      return ''
   endif
endfunction " }}}
function! GetMaybeAleWarnings() abort " {{{
   let l:counts         = ale#statusline#Count(bufnr(''))
   let l:all_errors     = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   if l:all_non_errors > 0
      if l:all_errors == 0
         call g:HL( 'FalklineAleLeft' , 'yellow' , g:FalklineMainB , 'none' )
      endif
      call g:HL( 'FalklineAleRight' , 'yellow' , g:FalklineMainB , 'none' )
      return printf("%d", l:all_non_errors)
   else
      return ''
   endif
   return l:all_non_errors == 0 ? '' : printf("%d", l:all_non_errors)
endfunction " }}}
function! GetMaybeAleSpacer() abort " {{{
   let l:counts            =  ale#statusline#Count(bufnr(''))
   let l:all_errors        =  l:counts.error + l:counts.style_error
   let l:all_non_errors    =  l:counts.total - l:all_errors
   return l:all_non_errors == 0 || l:all_errors == 0 ? '' : '▌'
endfunction " }}}
" ALE Functions }}}
function! RedrawModeColors(mode) " {{{
   " Toggle between bar and floating capsules depending on split status: {{{
   if len(tabpagebuflist()) == 1 || g:inGoyo == 1
      let g:FalklineMainA = 'mid_dark'
      let g:FalklineMainB = 'none'
   else
      let g:FalklineMainA = 'black'
      let g:FalklineMainB = 'mid_dark'
   endif
   call g:HL( 'StatusLine'             , 'yellow_light'  , g:FalklineMainB             )
   call g:HL( 'StatusLineNC'           , 'black'         , g:FalklineMainB  , 'bold'   )
   call g:HL( 'FalklineSeparator'      , 'mid_dark'      , g:FalklineMainA             )
   call g:HL( 'FalklineModified'       , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklineFiletype'       , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklineFiletypeBody'   , 'white'         , g:FalklineMainA  , 'italic' )
   call g:HL( 'FalklinePercentage'     , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklinePercentageBody' , 'dim_fg'        , g:FalklineMainA             )
   call g:HL( 'FalklineLineGit'        , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklineLineGitBody'    , 'dim_fg'        , g:FalklineMainA             )
   call g:HL( 'FalklineLineGitSymbol'  , 'white'         , g:FalklineMainA             )
   call g:HL( 'FalklineLineCol'        , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklineLineColBody'    , 'dim_fg'        , g:FalklineMainA             )
   call g:HL( 'FalklineFilename'       , 'white'         , g:FalklineMainA             )
   " }}}
   " Set mode dependent colors: {{{
   " Normal mode
   if a:mode == 'n'
     call g:HL( 'CursorLineNr'       , 'mode_normal_light'   , g:FalklineNLine         , 'bold' )
     call g:HL( 'CursorLine'         , 'none'                , g:FalklineNLine         , 'bold' )
     call g:HL( 'FalklineAccent'     , 'mode_normal_light'   , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_normal_dark'    , 'mode_normal_light'     , 'none' )
   " Insert mode
   elseif a:mode == 'i'
     call g:HL( 'CursorLineNr'       , 'mode_insert_light'   , 'mode_insert_dark'      , 'none' )
     call g:HL( 'CursorLine'         , 'none'                , 'mode_insert_dark'      , 'none' )
     call g:HL( 'FalklineAccent'     , 'mode_insert_light'   , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_insert_dark'    , 'mode_insert_light'     , 'none' )
   " Replace mode
   elseif a:mode == 'R'
     call g:HL( 'CursorLineNr'       , 'mode_replace_light'  , 'mode_replace_dark'     , 'bold' )
     call g:HL( 'CursorLine'         , 'none'                , 'mode_replace_dark'     , 'none' )
     call g:HL( 'FalklineAccent'     , 'mode_replace_light'  , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_replace_dark'   , 'mode_replace_light'    , 'none' )
   " Command mode
   elseif a:mode == 'c'
     call g:HL( 'CursorLineNr'       , 'mode_command_light'  , 'none'                  , 'none' )
     call g:HL( 'CursorLine'         , 'none'                , 'none'                  , 'none' )
     call g:HL( 'FalklineAccent'     , 'mode_command_light'  , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_command_dark'   , 'mode_command_light'    , 'none' )
   " Terminal mode
   elseif a:mode == 't'
     call g:HL( 'CursorLineNr'       , 'mode_terminal_light' , 'soft_dark'             , 'none' )
     call g:HL( 'CursorLine'         , 'none'                , 'soft_dark'             , 'none' )
     call g:HL( 'FalklineAccent'     , 'mode_terminal_light' , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_terminal_dark'  , 'mode_terminal_light'   , 'none' )
   " Visual mode
   else " a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
     call g:HL( 'CursorLineNr'       , 'mode_visual_light'   , 'soft_dark'             , 'none' )
     call g:HL( 'CursorLine'         , 'none'                , 'soft_dark'             , 'none' )
     call g:HL( 'FalklineAccent'     , 'mode_visual_light'   , 'none'                  , 'none' )
     call g:HL( 'FalklineAccentBody' , 'mode_visual_dark'    , 'mode_visual_light'     , 'none' )
   endif " }}} 
   return '' " Return empty string so as not to display anything in the statusline
endfunction
" }}}
" Cursor Line Mode Colors {{{
" Hack to make line bg reset after escaping from insert or replace mode
au InsertLeave * 
         \ call g:HL( 'CursorLine'   , 'none'              , g:FalklineNLine ) |
         \ call g:HL( 'CursorLineNr' , 'mode_normal_light' , g:FalklineNLine ) 
function! s:ModeColorChangeTrigger(id)
   call RedrawModeColors( mode() )
endfunction
call timer_start(100, function('s:ModeColorChangeTrigger'), {'repeat': -1})
" Cursor Line Mode Colors }}}
function! GetModeSymbol(mode) " {{{
" Normal mode
  if a:mode == 'n'
    return ''
" Insert mode
  elseif a:mode == 'i'
    return ''
" Replace mode
  elseif a:mode == 'R'
    return ''
" Command mode
  elseif a:mode == 'c'
    return 'גּ'
" Terminal mode
  elseif a:mode == 't'
    return ''
" Visual mode
  else "  a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
    return ''
  endif
endfunction " }}}
function! SetModifiedSymbol(modified) " {{{
   if a:modified == 1
      call g:HL( 'FalklineModifiedBody', 'red'  , g:FalklineMainA , 'bold' )
   else
      call g:HL( 'FalklineModifiedBody', 'green', g:FalklineMainA , 'bold' )
   endif
    return '● '
endfunction " }}}
function! SetFiletype(filetype) " {{{
   if a:filetype == ''
      return '-'
   else
      return a:filetype
  endif
endfunction " }}}
" Git Functions {{{
function! GetMaybeGitTransitionLeft() abort " {{{
   if strlen(FugitiveStatusline()) > 0
      return ''
   else
      return ''
   endif
endfunction " }}}
function! GetMaybeGitTransitionRight() abort " {{{
   if strlen(FugitiveStatusline()) > 0
      return ' '
   else
      return ''
   endif
endfunction " }}}
function! GetMaybeGitLogo() abort " {{{
   if strlen(FugitiveStatusline()) > 0
      return ''
   else
      return ''
   endif
endfunction " }}}
function! GetMaybeStatusText() abort " {{{
   return substitute( FugitiveStatusline(), '\[\(.\{-}\)\((.\{-})\)\=]', {m -> ''..(m[2]!=''?trim(m[2], '()'):m[1])..' '}, '')
endfunction " }}}
function! GetMaybeGitBranchSymbol() abort " {{{
   if strlen(FugitiveStatusline()) > 0
      return ''
   else
      return ''
   endif
endfunction " }}}
" Git Functions }}}
" Functions }}}
" Items {{{
" Hack to make the indicator proper when in command mode + padding
   set statusline=%{RedrawModeColors(mode())}%#Statusline#\ 

" Mode Indicator:
   set statusline+=%#FalklineAccent#
   set statusline+=%#FalklineAccentBody#%{GetModeSymbol(mode())}\ 

" Filename:
   set statusline+=%#FalklineFilename#\ %.40f

" File Modification Status:
   set statusline+=%#FalklineModifiedBody#\ %{SetModifiedSymbol(&modified)}
   set statusline+=%#FalklineModified#


" Statusbar Middle Spacer:
   set statusline+=%=


" Statusline Right Side Items:
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^


" ALE Warnings And Errors:
   set statusline+=%#FalklineAleLeft#
   set statusline+=%{GetMaybeAleOK()}
   set statusline+=%#FalklineAleErrorBody#%{GetMaybeAleErrors()}
   set statusline+=%#FalklineAleSpacer#%{GetMaybeAleSpacer()}
   set statusline+=%#FalklineAleWarningBody#%{GetMaybeAleWarnings()}
   set statusline+=%#FalklineAleRight#

" Padding:
   set statusline+=\ 

" Git: (Maybe) 
   set statusline+=%#FalklineLineGit#%{GetMaybeGitTransitionLeft()}
 " set statusline+=%#FalklineLineGitSymbol#%{GetMaybeGitLogo()}
   set statusline+=%#FalklineLineGitBody#%{GetMaybeStatusText()}
   set statusline+=%#FalklineLineGitSymbol#%{GetMaybeGitBranchSymbol()}
   set statusline+=%#FalklineLineGit#%{GetMaybeGitTransitionRight()}

" Line And Column:
   set statusline+=%#FalklineLineCol#
   set statusline+=%#FalklineLineColBody#%2l
   set statusline+=%#FalklineSeparator#\:
   set statusline+=%#FalklineLineColBody#%2c
   set statusline+=%#FalklineLineCol#

" Padding:
   set statusline+=\ 

" Current Scroll Percentage And Total Lines In Buffer:
   set statusline+=%#FalklinePercentage#
   set statusline+=%#FalklinePercentageBody#%P
   set statusline+=%#FalklineSeparator#\/
   set statusline+=%#FalklinePercentageBody#%L
   set statusline+=%#FalklinePercentage#

" Padding:
   set statusline+=\ 

" Filetype:
   set statusline+=%#FalklineFiletype#
   set statusline+=%#FalklineFiletypeBody#%{SetFiletype(&filetype)}
   set statusline+=%#FalklineFiletype#\  
" Items }}}
" Statusline }}}
