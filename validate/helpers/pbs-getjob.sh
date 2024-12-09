#!/bin/bash

qsub_cmd () {
    # Base case arguments [ USER SETTINGS -eq 0 ] && [ ADVANCED OPTIONS -eq 0]
    base_args="-A $project -q $queue -N vscc_${USER}" 
    select_args="-l select=$nodes:ncpus=$num_cpus:mem=$memory" 
    walltime_arg="-l walltime=$walltime"
    launch_pbs="-v walltime_seconds=$walltime_seconds launch.pbs"

    if [[ "$advanced_options" -eq 1 ]] || [[ "$user_settings" -eq 1 ]]; then
        if [ -n "$mpi_procs" ]; then
            select_args="$select_args:mpiprocs=$mpi_procs"
        fi

        if [ -n "$ompthreads" ]; then
            select_args="$select_args:ompthreads=$ompthreads"
        fi

        if [[ $gpu_count -gt 0 ]]; then
            select_args="$select_args:ngpus=$gpu_count"
            if [[ -n "$gpu_type" ]]; then
                select_args="$select_args -l gpu_type=$gpu_type"
            fi
        fi

        if [[ -n "$cpu_type" ]]; then
            select_args="$select_args -l cpu_type=$cpu_type"
        fi
    fi

    #echo "qsub $base_args $select_args $walltime_arg $launch_pbs"
    echo "qsub $base_args $select_args $walltime_arg $launch_pbs"
}

# --- Launch the job with PBS scheduler and collect the job ID --- #
qsub_call=$(qsub_cmd)
echo "Qsub request: $qsub_call"
job_id=$(eval $qsub_call)
qsub_status=$?

# Check that job ID was produced
if [[ $qsub_status != 0 ]]; then
    echo $qcmd_job
    echo "Error: error in qsub submission. Exiting ..."
    exit $qsub_status
fi

echo "$job_id"