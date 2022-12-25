import { NextApiRequest, NextApiResponse } from 'next/types';

export default function handler(_: NextApiRequest, res: NextApiResponse) {
  res.status(200).json({ status: 'ok' });
}
