function pps#apply_settings(project) abort
    if !pps#utils#set_project_dir(a:project)
        return
    endif

    call pps#vimrc#apply()
    call pps#tags#configure()
endfunction

