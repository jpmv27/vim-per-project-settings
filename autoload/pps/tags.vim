function! s:tags_file_path(name) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    if !isdirectory(dir)
        return ''
    endif

    return dir . '/' . a:name
endfunction

function! pps#tags#enable(name) abort
    let tags = s:tags_file_path(a:name)

    if tags ==# ''
        echo 'Could not enable tags per-project settings'
        return
    endif

    execute 'setlocal tags=' . tags
endfunction

