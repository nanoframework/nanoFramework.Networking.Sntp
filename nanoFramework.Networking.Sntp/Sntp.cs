//
// Copyright (c) .NET Foundation and Contributors
// See LICENSE file in the project root for full license information.
//

using System.Runtime.CompilerServices;

namespace nanoFramework.Networking
{
    /// <summary>
    /// Provides a set of methods that help manage the Simple Network Time Protocol (SNTP) client on the target device.
    /// </summary>
    /// <remarks>
    /// This class is specific to .NET nanoFramework.
    /// </remarks>
    public static class Sntp
    {
        /// <summary>
        /// Starts the SNTP client.
        /// After this method returns, a periodic call to the set SNTP servers is performed providing time synchronization.
        /// </summary>
        /// <remarks>
        /// <para>
        ///  The system time is updated immediately after each successful execution.
        /// </para>
        /// <para>
        /// By default the time synchronization occurs on a hourly rate.
        /// </para>
        /// </remarks>
        [MethodImpl(MethodImplOptions.InternalCall)]
        public static extern void Start();

        /// <summary>
        /// Stops the SNTP client.
        /// The time synchronization will stop.
        /// </summary>
        [MethodImpl(MethodImplOptions.InternalCall)]
        public static extern void Stop();

        /// <summary>
        /// Performs an immediate request to synchronize time.
        /// </summary>
        /// <remarks>
        /// This performs a restart of the internal service.
        /// </remarks>
        [MethodImpl(MethodImplOptions.InternalCall)]
        public static extern void UpdateNow();

        /// <summary>
        /// Get status of SNTP client.
        /// </summary>
        public static extern bool IsStarted
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;
        }

        /// <summary>
        /// Gets, sets the host address of the main SNTP server.
        /// By default it uses the server '0.pool.ntp.org'
        /// </summary>
        /// <remarks>
        /// For a list of some public NTP servers, see this link :
        /// http://support.ntp.org/bin/view/Servers/NTPPoolServers
        /// </remarks>
        public static extern string Server1
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;

            [MethodImpl(MethodImplOptions.InternalCall)]
            set;
        }

        /// <summary>
        /// Gets, sets the host address of the backup SNTP server.
        /// By default it uses the server '1.pool.ntp.org'
        /// </summary>
        /// <remarks>
        /// For a list of some public NTP servers, see this link :
        /// http://support.ntp.org/bin/view/Servers/NTPPoolServers
        /// </remarks>
        public static extern string Server2
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;

            [MethodImpl(MethodImplOptions.InternalCall)]
            set;
        }

        // /// <summary>
        // /// Gets or Sets the update interval of the SNTP client (in milliseconds) from when the service was started.
        // /// </summary>
        // public static extern int UpdateInterval
        // {
        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     get;

        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     set;
        // }

        // /// <summary>
        // /// Gets or Sets the Startup delay of the SNTP client (in milliseconds) when the service is started.
        // /// </summary>
        // public static extern int StartupDelay
        // {
        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     get;

        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     set;
        // }

        // /// <summary>
        // /// Gets or Sets the Retry period (in milliseconds) the SNTP client will use.
        // /// </summary>
        // public static extern short RetryPeriod
        // {
        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     get;

        //     [MethodImpl(MethodImplOptions.InternalCall)]
        //     set;
        // }
    }
}
