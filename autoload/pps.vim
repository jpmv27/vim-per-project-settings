function pps#apply_settings(project) abort
    if !exists('g:pps_base_dir')
        echo 'You must define g:pps_base_dir'
        return
    endif

    let dir = resolve(expand(g:pps_base_dir))

    " Per-project vimrc
    let vimrc = dir . '/' . a:project . '/vimrc'
    if filereadable(vimrc)
        execute 'source' vimrc
    endif

    " Per-project tags file
    let tags = dir . '/' . a:project . '/tags'
    if filereadable(tags)
        execute 'setlocal tags=' . tags
    endif
endfunction
