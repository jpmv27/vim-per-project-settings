function! s:tags_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    if !isdirectory(dir)
        return ''
    endif

    return dir . '/tags'
endfunction

function! pps#tags#configure(active) abort
    let active = a:active

    if active
        let tags = s:tags_file_path()

        if tags ==# ''
            let active = 0
        endif
    endif

    if active
        let b:tagmgr_tags_file = tags
        execute 'setlocal tags=' . tags
    else
        let b:tagmgr_tags_file = ''
        setlocal tags=
    endif
endfunction

