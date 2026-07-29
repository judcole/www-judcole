import dayjs from "dayjs"
import localizedFormat from "dayjs/plugin/localizedFormat"

// The "ll" localized format (e.g. "May 10, 2026") requires this plugin;
// registering it here means no caller can forget it
dayjs.extend(localizedFormat)

// Format a date for display, e.g. "May 10, 2026"
export default function formatDate(date: Date): string {
  return dayjs(date).format("ll")
}
