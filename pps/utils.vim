function pps#utils#set_project_dir(project) abort
    if !exists('g:pps_base_dir')
        echo 'You must define g:pps_base_dir'
        return 0
    endif

    let dir = resolve(fnameescape(expand(g:pps_base_dir) . '/' . a:project))

    if isdirectory(dir)
        let b:pps_project_dir = dir
        return 1
    else
        if exists('b:pps_project_dir')
            unlet b:pps_project_dir
        endif

        return 0
    endif
endfunction

