let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'codesearch',
      \ 'max_candidates': 30,
      \ 'is_volatile': 1,
      \ 'required_pattern_length': 3,
      \ }

if exists('g:unite_codesearch_command')
  let s:codesearch_command = g:unite_codesearch_command
elseif executable('csearch')
  let s:codesearch_command = 'csearch -m %d -l %s'
endif

function! s:unite_source.gather_candidates(args, context)
  return map(
        \ split(
        \   unite#util#system(printf(
        \     s:codesearch_command,
        \     s:unite_source.max_candidates,
        \     a:context.input)),
        \   "\n"),
        \ '{
        \ "word": v:val,
        \ "source": "codesearch",
        \ "kind": "file",
        \ "action__path": v:val,
        \ "action__directory": fnamemodify(v:val, ":p:h"),
        \ }')
endfunction

function! unite#sources#codesearch#define()
  return exists('s:codesearch_command') ? s:unite_source : []
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
