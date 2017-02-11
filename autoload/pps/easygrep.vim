let s:global_context_name = '###GLOBAL###'
lockvar s:global_context_name

function! s:save_settings(var) abort
    for [item, val] in items(g:)
        if match(item, 'EasyGrep[^_]') == 0
            let a:var[item] = val
        endif
    endfor
endfunction

function! s:restore_settings(var) abort
    for [item, val] in items(a:var)
        let q = (type(val) == 1) ? "'" : ''
        execute 'let g:' . item . '=' . q . val . q
    endfor
endfunction

function! s:init_context(var) abort
    if !exists('s:context_store')
        let s:context_store = {}
    endif

    if !exists('s:context_store[a:var]')
        let s:context_store[a:var] = {}
    endif
endfunction

function! s:save_current_context() abort
    call s:init_context(s:current_context)
    call s:save_settings(s:context_store[s:current_context])
endfunction

function! s:switch_context(var) abort
    call s:init_context(a:var)
    call s:restore_settings(s:context_store[a:var])
    let s:current_context = a:var
endfunction

function! pps#easygrep#enable() abort
    if !exists('b:pps_project_name')
        return
    endif

    call s:switch_context(b:pps_project_name)

    nmap <buffer> <leader>vo :echo '\vo is not supported when EasyGrep PPS is enabled'<cr>
endfunction

function! pps#easygrep#restore() abort
    call s:save_current_context()
    if s:current_context !=# s:global_context_name
        call s:switch_context(s:global_context_name)
    endif
endfunction

augroup pps_eg
    autocmd!
    autocmd BufLeave * call pps#easygrep#restore()
augroup END

let s:current_context = s:global_context_name
call s:save_current_context()
