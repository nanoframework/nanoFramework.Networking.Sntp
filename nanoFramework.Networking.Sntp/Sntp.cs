//
// Copyright (c) .NET Foundation and Contributors
// See LICENSE file in the project root for full license information.
//

using System.Runtime.CompilerServices;

namespace nanoFramework.Networking
{
    /// <summary>
    /// Provides a set of methods that help developers to manage the SNTP (Simple Network Time Protocol) client on the target device.
    /// </summary>
    /// <remarks>
    /// For a list of some public NTP servers, see this link :
    /// http://support.ntp.org/bin/view/Servers/NTPPoolServers
    /// </remarks>
    public static class Sntp
    {
        /// <summary>
        /// Starts the SNTP client.
        /// After this method returns a periodic call to the set SNTP servers is performed providing time synchronization.
        /// The system time is updated immediately after each successful execution.
        /// The time synchronization occurs on a hourly rate.
        /// </summary>
        /// <remarks>This method is specific to nanoFramework.</remarks>
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
        /// Gets, sets the address of the SNTP server 1.
        /// </summary>
        public static extern string Server1
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;

            [MethodImpl(MethodImplOptions.InternalCall)]
            set;
        }

        /// <summary>
        /// Gets, sets the address of the SNTP server 2.
        /// </summary>
        public static extern string Server2
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;

            [MethodImpl(MethodImplOptions.InternalCall)]
            set;
        }

        /// <summary>
        /// Gets, sets the update interval of the SNTP client (in minutes).
        /// </summary>
        /// <remarks>This method is specific to nanoFramework.</remarks>
        public static extern int UpdateInterval
        {
            [MethodImpl(MethodImplOptions.InternalCall)]
            get;

            [MethodImpl(MethodImplOptions.InternalCall)]
            set;
        }
    }
}
