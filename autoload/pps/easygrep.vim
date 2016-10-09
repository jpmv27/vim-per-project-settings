function! s:easygrep_file_path(name) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    if !isdirectory(dir)
        return ''
    endif

    return dir . '/' . a:name
endfunction

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

function! pps#easygrep#enable(name) abort
    let easygrep = s:easygrep_file_path(a:name)

    if easygrep ==# '' || !filereadable(easygrep)
        echo 'Could not enable easygrep per-project settings'
        return
    endif

    let b:pps_eg_settings = {}
    call s:save_settings(b:pps_eg_settings)

    execute 'source ' . easygrep

    augroup pps_eg
        autocmd!
        autocmd BufLeave <buffer> call pps#easygrep#restore()
    augroup END
endfunction

function! pps#easygrep#restore() abort
    if !exists('b:pps_eg_settings')
        return
    endif

    call s:restore_settings(b:pps_eg_settings)

    unlet b:pps_eg_settings
endfunction

