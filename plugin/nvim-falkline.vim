" TODO: Git stats in git blob
" Falkline {{{
" NOTE: Might also be set in RedrawModeColors!
call g:HL( 'StatusLine'                , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'StatusLineNC'              , 'black'      , 'none'       , 'bold'   )
call g:HL( 'FalklineSeparator'         , 'dark_fg'    , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineModified'          , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineFiletype'          , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineFiletypeBody'      , 'white'      , 'mid_dark'   , 'italic' )
call g:HL( 'FalklinePercentage'        , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklinePercentageBody'    , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineGit'           , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineLineGitBody'       , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineGitSymbol'     , 'white'      , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineLineCol'           , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineLineColBody'       , 'dim_fg'     , 'mid_dark'   , 'none'   )
call g:HL( 'FalklineStatusMsgBody'     , 'white'      , 'mid_dark'   , 'bold'   )
call g:HL( 'FalklineStatusMsg'         , 'mid_dark'   , 'none'       , 'none'   )
call g:HL( 'FalklineStatusOkBody'      , 'white'      , 'green'      , 'bold'   )
call g:HL( 'FalklineStatusWarningBody' , 'red'        , 'yellow'     , 'bold'   )
call g:HL( 'FalklineStatusErrorBody'   , 'white'      , 'red'        , 'bold'   )
call g:HL( 'FalklineStatusSpacer'      , 'red'        , 'yellow'     , 'none'   )
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
" Coc Functions {{{
function! GetMaybeStatusMsgLeft() abort " {{{
	if get(g:, 'coc_status', '') == ''
		return ''
	else
		return ''
	endif
endfunction " }}}
function! GetMaybeStatusMsgRight() abort " {{{
	if get(g:, 'coc_status', '') == ''
		return ''
	else
		return ''
	endif
endfunction " }}}
function! GetMaybeCocStatusMsg() abort " {{{
  return get(g:, 'coc_status', '')
endfunction " }}}
function! GetMaybeCocOK() abort " {{{
	let info = get(b:, 'coc_diagnostic_info', {})
   if empty(info) | return '' | endif
   if !get(info, 'error', 0) && !get(info, 'warning', 0)
      call g:HL( 'FalklineStatusLeft'  , 'green' , g:FalklineMainB , 'none' )
      call g:HL( 'FalklineStatusRight' , 'green' , g:FalklineMainB , 'none' )
   endif
   return ''
endfunction " }}}
function! GetMaybeCocErrors() abort " {{{
	let info            = get(b:, 'coc_diagnostic_info', {})
   if empty(info) | return '' | endif
   let l:warning_count = get(info,'warning',0)
   let l:error_count   = get(info,'error',0)
   if l:error_count > 0
      call g:HL( 'FalklineStatusLeft' , 'red' , g:FalklineMainB , 'none' )
      if l:warning_count == 0
         call g:HL( 'FalklineStatusRight' , 'red' , g:FalklineMainB , 'none' )
      endif
      return printf("%d", l:error_count)
   else
      return ''
   endif
endfunction " }}}
function! GetMaybeCocWarnings() abort " {{{
	let info            = get(b:, 'coc_diagnostic_info', {})
   if empty(info) | return '' | endif
   let l:warning_count = get(info,'warning',0)
   let l:error_count   = get(info,'error',0)
   if l:warning_count > 0
      if l:error_count == 0
         call g:HL( 'FalklineStatusLeft' , 'yellow' , g:FalklineMainB , 'none' )
      endif
      call g:HL( 'FalklineStatusRight' , 'yellow' , g:FalklineMainB , 'none' )
      return printf("%d", l:warning_count)
   else
      return ''
   endif
   "return l:all_non_errors == 0 ? '' : printf("%d", l:all_non_errors) " TODO: remove?
endfunction " }}}
function! GetMaybeCocSpacer() abort " {{{
	let info            = get(b:, 'coc_diagnostic_info', {})
   if empty(info) | return '' | endif
   let l:warning_count = get(info,'warning',0)
   let l:error_count   = get(info,'error',0)
   return l:error_count && l:warning_count ? '▌' : ''
endfunction " }}}
" Coc Functions }}}
" " ALE Functions {{{
" function! GetMaybeAleOK() abort " {{{
"    let l:counts      =  ale#statusline#Count(bufnr(''))
"    if l:counts.total == 0
"       call g:HL( 'FalklineStatusLeft'  , 'green' , g:FalklineMainB , 'none' )
"       call g:HL( 'FalklineStatusRight' , 'green' , g:FalklineMainB , 'none' )
"    endif
"    return ''
" endfunction " }}}
" function! GetMaybeAleErrors() abort " {{{
"    let l:counts         = ale#statusline#Count(bufnr(''))
"    let l:all_errors     = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"    if l:all_errors > 0
"       call g:HL( 'FalklineStatusLeft' , 'red' , g:FalklineMainB , 'none' )
"       if l:all_non_errors == 0
"          call g:HL( 'FalklineStatusRight' , 'red' , g:FalklineMainB , 'none' )
"       endif
"       return printf("%d", l:all_errors)
"    else
"       return ''
"    endif
" endfunction " }}}
" function! GetMaybeAleWarnings() abort " {{{
"    let l:counts         = ale#statusline#Count(bufnr(''))
"    let l:all_errors     = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"    if l:all_non_errors > 0
"       if l:all_errors == 0
"          call g:HL( 'FalklineStatusLeft' , 'yellow' , g:FalklineMainB , 'none' )
"       endif
"       call g:HL( 'FalklineStatusRight' , 'yellow' , g:FalklineMainB , 'none' )
"       return printf("%d", l:all_non_errors)
"    else
"       return ''
"    endif
"    return l:all_non_errors == 0 ? '' : printf("%d", l:all_non_errors)
" endfunction " }}}
" function! GetMaybeAleSpacer() abort " {{{
"    let l:counts            =  ale#statusline#Count(bufnr(''))
"    let l:all_errors        =  l:counts.error + l:counts.style_error
"    let l:all_non_errors    =  l:counts.total - l:all_errors
"    return l:all_non_errors == 0 || l:all_errors == 0 ? '' : '▌'
" endfunction " }}}
" " ALE Functions }}}
function! RedrawModeColors(mode) " {{{
   " Toggle between bar and floating capsules depending on split status: {{{
   if len(tabpagebuflist()) == 1 || g:inGoyo == 1
      let g:FalklineMainA = 'mid_dark'
      let g:FalklineMainB = 'none'
   else
      let g:FalklineMainA = 'dark_dark'
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
   call g:HL( 'FalklineStatusMsg'      , g:FalklineMainA , g:FalklineMainB             )
   call g:HL( 'FalklineStatusMsgBody'  , 'white'         , g:FalklineMainA             )
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
" Items {{{{{{
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


" Coc Warnings And Errors:
   set statusline+=%#FalklineStatusMsg#%{GetMaybeStatusMsgLeft()}
	set statusline+=%#FalklineStatusMsgBody#%{GetMaybeCocStatusMsg()}
   set statusline+=%#FalklineStatusMsg#%{GetMaybeStatusMsgRight()}
	" Padding:
		set statusline+=\ 
   set statusline+=%#FalklineStatusLeft#
   set statusline+=%{GetMaybeCocOK()}
   set statusline+=%#FalklineStatusErrorBody#%{GetMaybeCocErrors()}
   set statusline+=%#FalklineStatusSpacer#%{GetMaybeCocSpacer()}
   set statusline+=%#FalklineStatusWarningBody#%{GetMaybeCocWarnings()}
   set statusline+=%#FalklineStatusRight#

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
